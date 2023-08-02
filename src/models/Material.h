#ifndef MATERIAL_H
#define MATERIAL_H

#include <string>

class Material {
public:
    Material(const std::string& name,  double density);
    Material() {}
    // Getters
    std::string getName() const;
    double getDensity() const;

    // Setters
    void setName(const std::string& name);
    void setDensity(double density);

private:
    std::string name;
    double density;
};

#endif // MATERIAL_H
