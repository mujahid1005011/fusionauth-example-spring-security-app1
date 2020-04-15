#set -x
PROJECT_HOME="/home/mujahid/Projects"
FA_VERSION="1.15.8"
APP_FOLDER_NAME="fusionauth-app-n-search-${FA_VERSION}"
FA_HOME="${PROJECT_HOME}/${APP_FOLDER_NAME}"

# shellcheck disable=SC2120

function download() {
  cd $PROJECT_HOME
  ZIP_DOWNLOAD_URL="https://bitbucket.org/mujahid1005011/projects/raw/488e75d3071d800480f9fe12a15db8388c846799/fusionauth-app-n-search.zip"
  echo "Dowloading app from: "$ZIP_DOWNLOAD_URL
  wget -O $APP_FOLDER_NAME".zip" $ZIP_DOWNLOAD_URL
  unzip -d $APP_FOLDER_NAME $APP_FOLDER_NAME".zip"
  cd -
  start_server
}

function start_server() {
    APP_START_SCRIPT_PATH=$FA_HOME"/bin/startup.sh"
    if [ ! -f ${APP_START_SCRIPT_PATH} ]; then
        echo "App Start up script not found. Delete folder: ${FA_HOME} & run again"
    fi
    $APP_START_SCRIPT_PATH
}

function stutdown_server() {
    SEARCH_SHUTDOWN_SCRIPT_PATH=$FA_HOME"/bin/shutdown.sh"
    if [ ! -f ${SEARCH_SHUTDOWN_SCRIPT_PATH} ]; then
        echo "App Shutdown up script not found. Cannot shutdown..."
        exit 1
    fi
    $SEARCH_SHUTDOWN_SCRIPT_PATH
}
function start_seq() {
    if [ -d ${FA_HOME} ]; then
      echo "Fusion auth home direction exists. Starting server..."
      start_server
    else
      echo "Fusion not found... Fusion Auth ${FA_VERSION} will be downloaded @ ${PROJECT_HOME}"
      download
    fi
}

function stop_seq() {
    if [ -d ${FA_HOME} ]; then
      echo "Fusion auth home direction exists. Stopping server..."
      stutdown_server
    fi
}

function check() {

  case $1 in
  "start")
    echo "Initiating startup sequence..."
    start_seq
    exit 0
    ;;
  "stop")
    echo "Shutting down..."
    stop_seq
    exit 0
    ;;
  "status")
    echo "Checking status..."
    exit 0
    ;;
  esac

  echo "Invalid argument"
  echo "${0} start"
  echo "${0} stop"
  echo "${0} status"
  exit 0
}

check $1







