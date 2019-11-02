#!/bin/sh

#  build-number-increases.sh
#  DrugProphet
#
#  Created by nslog on 2019/11/1.
#  Copyright © 2019 Chance. All rights reserved.

# Build Number Increases
# Type a script or drag a script file from your workspace to insert its path.
if [ $CONFIGURATION == Release -o $CONFIGURATION == ReleaseSit ]; then
  export PATH=$PATH:/usr/libexec

  # plist 文件
  PLIST_FILE=${PROJECT_DIR}/${INFOPLIST_FILE}
  # pbxproj 文件
  PBXPROJ_FILE="$PROJECT_FILE_PATH/project.pbxproj"

  CPV="CURRENT_PROJECT_VERSION"
  DT="DEVELOPMENT_TEAM"

  echo "Upgrading build version number..."

  BUILD_VERSION=$(PlistBuddy -c "Print CFBundleVersion" "$PLIST_FILE")
  
  if [[ $BUILD_VERSION == '$('"$CPV"')' ]]; then
    build=$(grep -o -m 1 "$CPV = [0-9\.]*" $PBXPROJ_FILE) # CURRENT_PROJECT.. = 1.0
    if [[ $build == "" ]]; then
      # 不存在
      perl -pi -e "s|$DT =|$CPV = 1.0;\n\t\t\t\t$DT =|g" "$PBXPROJ_FILE"
      echo "Set build number to 1.0"
    else
      # 存在
      n=${build#*=} # 1.0
      nx=$(expr "scale=1;$n+0.1" | bc)
      perl -pi -e "s|$build|$CPV = $nx|g" "$PBXPROJ_FILE"
      echo "Upgraded build number to $nx"
    fi
  else
    if [[ $BUILD_VERSION == "" ]]; then
      # Set the default build number
      BUILD_VERSION="1.0"
      echo "Set build number to 1.0"
    else
      # Increment the build number (ie 1.0 to 1.1)
      BUILD_VERSION=$(expr "scale=1;$BUILD_VERSION+0.1" | bc)
      echo "Upgraded build number to $BUILD_VERSION"
    fi
    PlistBuddy -c "Set CFBundleVersion $BUILD_VERSION" "$PLIST_FILE"
  fi
else
  echo "$CONFIGURATION build - Unupgraded build number."
fi
