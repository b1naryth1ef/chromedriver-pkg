# This script creates a new chromedriver debian package from the latest release version
RELEASE=`wget -qO- http://chromedriver.storage.googleapis.com/LATEST_RELEASE`
OUTPUT=${1-"deb"}

echo "Downloading latest chromedriver ($RELEASE)"
wget -q http://chromedriver.storage.googleapis.com/$RELEASE/chromedriver_linux64.zip

echo "Extracting zip"
unzip chromedriver_linux64.zip

echo "Moving chromedriver binary into place (/usr/bin/chromedriver)..."
sudo mv chromedriver /usr/bin/chromedriver

echo "Updating control file with version..."
sed -i "s/Version:.*/Version: $RELEASE/g" control

echo "Generating package with FPM..."
fpm -s dir -t $OUTPUT -n chromedriver --deb-custom-control control -n "chromedriver_${RELEASE}" /usr/bin/chromedriver

echo "Cleaning up..."
rm chromedriver_linux64.zip

echo "FINISHED!"

