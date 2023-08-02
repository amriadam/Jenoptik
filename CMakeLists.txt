cmake_minimum_required(VERSION 3.21.1)

set(BUILD_QDS_COMPONENTS ON CACHE BOOL "Build design studio components")

project(JenoptikApp LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOMOC ON)

find_package(QT NAMES Qt6 COMPONENTS Gui Qml Quick Sql)
find_package(Qt6 REQUIRED COMPONENTS Core Qml Quick Sql)

# To build this application you need Qt 6.2.0 or higher
if (Qt6_VERSION VERSION_LESS 6.2.0)
message(FATAL_ERROR "You need Qt 6.2.0 or newer to build the application.")
endif()

qt_add_executable(${CMAKE_PROJECT_NAME} src/main.cpp src/resources.qrc  src/database/DBConnection.cpp
    src/models/LaserParam.cpp
    src/models/LaserParam.h
    src/models/Material.cpp
    src/models/Material.h
    src/services/LaserParamService.h src/services/LaserParamService.cpp
    src/controllers/LaserParamController.h src/controllers/LaserParamController.cpp
    qml/components/dialogs/MaterialDialog.qml
    src/controllers/MaterialController.h src/controllers/MaterialController.cpp
    src/services/MaterialService.h src/services/MaterialService.cpp
    qml/components/shared/NotificationBanner.qml
    qml/components/EventBus.qml
    )

# qt_standard_project_setup() requires Qt 6.3 or higher. See https://doc.qt.io/qt-6/qt-standard-project-setup.html for details.
if (${QT_VERSION_MINOR} GREATER_EQUAL 3)
qt6_standard_project_setup()
endif()

qt_add_resources(${CMAKE_PROJECT_NAME} "configuration"
    PREFIX "/"
    FILES
        qtquickcontrols2.conf
)

target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE
    Qt${QT_VERSION_MAJOR}::Core
    Qt${QT_VERSION_MAJOR}::Gui
    Qt${QT_VERSION_MAJOR}::Quick
    Qt${QT_VERSION_MAJOR}::Qml
    Qt${QT_VERSION_MAJOR}::Sql
)

if (${BUILD_QDS_COMPONENTS})
    include(${CMAKE_CURRENT_SOURCE_DIR}/qmlcomponents)
endif ()

include(${CMAKE_CURRENT_SOURCE_DIR}/qmlmodules)
