cmake_minimum_required(VERSION 3.1)

project(mcpelauncher-errorwindow LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

option(ENABLE_QT_ERROR_UI "Build this QT component to show errormessages" TRUE)

if (ENABLE_QT_ERROR_UI AND (BUILD_UI OR NOT DEFINED BUILD_UI))
    find_package(Qt6 COMPONENTS Core Quick Widgets REQUIRED)

    find_package(Qt6LinguistTools)
    set(LAUNCHER_LINGUIST_RESOURCES "")
    if (Qt6LinguistTools_FOUND)
        qt6_create_translation(QM_FILES ${CMAKE_CURRENT_SOURCE_DIR} mcpelauncher_en.ts)
        configure_file(translations.qrc ${CMAKE_CURRENT_BINARY_DIR} COPYONLY)
        set(LAUNCHER_LINGUIST_RESOURCES ${CMAKE_CURRENT_BINARY_DIR}/translations.qrc ${QM_FILES})
    endif()

    qt6_add_resources(RESOURCES qml.qrc)
    set(RESOURCES ${RESOURCES} ${LAUNCHER_LINGUIST_RESOURCES})

    add_executable(mcpelauncher-error src/main.cpp ${RESOURCES})

    target_link_libraries(mcpelauncher-error Qt6::Core Qt6::Quick Qt6::Widgets)

    install(TARGETS mcpelauncher-error RUNTIME COMPONENT mcpelauncher-error DESTINATION bin)
endif()

if (NOT DEFINED BUILD_CLIENT OR BUILD_CLIENT)
    add_library(mcpelauncher-errorwindow src/errorwindow.cpp)
    target_link_libraries(mcpelauncher-errorwindow gamewindow file-util)
    target_include_directories(mcpelauncher-errorwindow PUBLIC include)
endif()
