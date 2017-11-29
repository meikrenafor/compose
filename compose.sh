#!/bin/bash

echo "Preparations for website deployment started...";

echo -n "Clearing cache for PROD environment... ";
php app/console cache:clear --env=prod --no-debug;
echo "Done! [1/6]";

echo -n "Removing existing CSS folder... ";
rm -rf web/css;
echo "Done! [2/6]";

echo -n "Removing existing JS folder... ";
rm -rf web/js;
echo "Done! [3/6]";

echo -n "Running assets build for PROD environment... ";
php app/console assets:install --env=prod --no-debug;
php app/console assetic:dump --env=prod --no-debug;
echo "Done! [4/6]";

echo -n "Adding assets to git index... ";
git add web/css -f;
git add web/js -f;
echo "Done! [5/6]";

echo -n "Updating Composer Bundles for PROD environment... ";
SYMFONY_ENV=prod composer update --no-ansi --no-dev --no-interaction --no-progress --optimize-autoloader --quiet --no-scripts;
echo "Done! [6/6]";

composer install;

echo "Preparations completed. Website is ready for deploy.";
