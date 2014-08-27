#!/usr/bin/perl
# ------------------------------------------------------------------------------------
#  Program for downloading XPlanet cloud images from a random mirror
# 
#  Copyright (c) 2003, cueSim Ltd.                  http://www.cueSim.com, Bedford, UK
#  
# ------------------------------------------------------------------------------------
#  
#  Redistribution and use, with or without modification, are permitted provided 
#  that the following conditions are met:
#  
#      * Redistributions of source code must retain the above copyright notice, 
#     this list of conditions and the following disclaimer.
#      * Neither the cueSim name nor the names of its contributors may 
#     be used to endorse or promote products derived from this software without 
#     specific prior written permission.
#  
#  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY 
#  EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES 
#  OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT 
#  SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
#  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT 
#  OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) 
#  HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, 
#  OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS 
#  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
# 
# (2005-06) hacked by mose at nguild.org for personal use on a debian SID
# (2008-08) hacked by benhaim_jerome at yahoo.fr for personal use on a ubuntu Hardy
 
use LWP::Simple;
 
# Options:
#  - ou sauvegarder l'image des nuages (par defaut le répertoire courant)
# 
 
my $Filename = "/home/wilk/.xplanet/images/clouds.jpg";
 
# - fréquences de mise à jour de l'image sur le serveur
my $MaxDownloadFrequencyHours = 2;
 
# - Combien d'essais, si le serveur ne répond pas 
my $MaxRetries = 3;
 
## Note: excessive requests to a single image server is discouraged.
## This script limits max retries, does not download more frequently
## than every two hours (the file is generated every 3 hours). and 
## picks a random mirror location for every download.
##
## Changer les paramètres risque de vous exclure (blacklisted)
## des serveurs d'images
 
if(-f $Filename) {
  my @Stats = stat($Filename);
  my $FileAge = (time() - $Stats[9]);
  my $FileSize = $Stats[7];
  if($FileAge < 60 * 60 * $MaxDownloadFrequencyHours && $FileSize > 400000) {
    print "File is already up to date\n";
    exit(1);
  }
}
 
for(1..$MaxRetries) {
  my $MirrorURL = GetRandomMirror();
  print "Using $MirrorURL\nDownloading...\n";
  my $Response = getstore($MirrorURL, $Filename);
  if( IndicatesSuccess($Response)) {
    print "Finished: file successfully downloaded to $Filename\n";
    exit(0);
  }
  print "Download not available, trying another website\n\n";
}
print "ERROR: Tried to download the file $MaxRetries times, but no servers could provide the file\n";
exit(2);
 
sub IndicatesSuccess() {
  my $Response = shift();
  if($Response =~ /2\d\d/) {
    return(1); 
  } else {
    return(0);
  } 
} 
## Liste des serveurs miroir
sub GetRandomMirror() {
  my @Mirrors = (
     "http://xplanet.sourceforge.net/clouds/clouds_2048.jpg",
     "http://www.ruwenzori.net/earth/clouds_2048.jpg",
     "http://xplanet.dyndns.org/clouds/clouds_2048.jpg",
     "http://userpage.fu-berlin.de/~jml/clouds_2048.jpg",
     "http://userpage.fu-berlin.de/~jml/clouds_4096.jpg",
     "http://php.nctu.edu.tw/~ijliao/clouds_2048.jpg",
     "http://home.megapass.co.kr/~gitto88/cloud_data/clouds_2048.jpg",
     "http://home.megapass.co.kr/~holywatr/cloud_data/clouds_2048.jpg",
     "ftp://ftp.iastate.edu/pub/xplanet/clouds_2048.jpg",
     "http://xplanet.explore-the-world.net/clouds_2048.jpg",
     "ftp://mirror.pacific.net.au/xplanet/clouds_2048.jpg",
     "http://www.narrabri.atnf.csiro.au/operations/NASA/clouds_2048.jpg",
  );
  return $Mirrors[rand scalar(@Mirrors)];
}

