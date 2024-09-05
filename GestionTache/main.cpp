/**
 * @file main.cpp
 * @brief Entry point for the Qt application.
 *
 * This file sets up and runs the main Qt application. It initializes the application engine for loading
 * QML files and handles application lifecycle events.
 */
#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    // Create a QGuiApplication object, which manages application-wide resources and settings.
    QGuiApplication app(argc, argv);

    app.setOrganizationName("somename");
    app.setOrganizationDomain("somename");

    // Create a QQmlApplicationEngine object, which loads and manages QML files.
    QQmlApplicationEngine engine;

    // Connect the objectCreationFailed signal to the QCoreApplication::exit slot to handle QML object creation errors.
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    // Load the QML module named "GestionTache" and the QML file named "Main.qml".
    engine.loadFromModule("GestionTache", "Main");

    return app.exec();
}
