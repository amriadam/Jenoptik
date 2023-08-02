#include "dbconnection.h"
#include <QSqlError>
#include <QDebug>
#include <QSqlQuery>

DBConnection::DBConnection() : db(QSqlDatabase::addDatabase("QSQLITE")) {
    db.setDatabaseName("Jenoptik");
    db.setUserName("adam");
    db.setPassword("adam");
}

DBConnection::~DBConnection()
{
    closeDatabase();
}

bool DBConnection::openDatabase()
{
    if(db.open())
        return true;
    else
        return false;
}

bool DBConnection::createMaterialTable()
{
    // First, check if the database connection is open
    if(!db.isOpen()) {
        qDebug() << "Database is not open!";
        return false;
    }

    // Create a new QSqlQuery object
    QSqlQuery query;

    // Prepare a CREATE TABLE query
    query.prepare(
        "CREATE TABLE IF NOT EXISTS material ("
        "id INTEGER PRIMARY KEY,"
        "name TEXT,"
        "density REAL)"
        );

    // Execute the query and check if it was successful
    if(query.exec())
        return true;
    else {
        qDebug() << "Material table creation failed: " << query.lastError();
        return false;
    }
}

void DBConnection::insertMaterial(const QString& name, double density) {
    if (!db.open()) {
        qDebug() << "Error occurred opening the database.";
        qDebug() << "Error: " << db.lastError().text();
        return;
    }

    QSqlQuery query(db);

    query.prepare("INSERT INTO material (name, density) VALUES (?, ?)");
    query.addBindValue(name);
    query.addBindValue(density);

    if (!query.exec()) {
        qDebug() << "Error occurred inserting.";
        qDebug() << "Error: " << query.lastError().text();
        return;
    }

    db.close();
}




void DBConnection::closeDatabase()
{
    db.close();
}
