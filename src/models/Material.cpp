#include "Material.h"

Material::Material(const std::string& name,  double density)
    : name(name),density(density)
{
}

// Getters
std::string Material::getName() const
{
    return this->name;
}


double Material::getDensity() const
{
    return this->density;
}

// Setters
void Material::setName(const std::string& name)
{
    this->name = name;
}

void Material::setDensity(double density)
{
    this->density = density;
}
