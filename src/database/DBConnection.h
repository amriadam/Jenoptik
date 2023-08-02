#ifndef DBCONNECTION_H
#define DBCONNECTION_H
#include <QSqlDatabase>

class DBConnection
{
public:
    DBConnection();
    ~DBConnection();

    bool openDatabase();
    void closeDatabase();
    bool createMaterialTable();
    void insertMaterial(const QString &name, double density);
private:
    QSqlDatabase db;
};
#endif // DBCONNECTION_H
