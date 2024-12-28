//
//  TaylorBridge.cpp
//  FADBADSwift
//
//  Created by Leonard Chan on 12/27/24.
//

#include "TaylorBridge.hpp"

#include <iostream>

namespace fadbad
{
namespace bridge
{

TaylorBridge::TaylorBridge(const double& value)
{
    TDB x = value;
    m_taylorType = x;
    return this;
}

TaylorBridge::TaylorBridge(const TDB& value)
{
    m_taylorType = value;
    return this;
}

const TDB& TaylorBridge::getTaylorType() const
{
    return m_taylorType;
}

const double TaylorBridge::getSubscriptValue(const int& index)
{
    return m_taylorType[index];
}

void TaylorBridge::setSubscriptValue(const int& index, const double& value)
{
    m_taylorType[index] = value;
}

unsigned int TaylorBridge::eval(const unsigned int& i)
{
    return m_taylorType.eval(i);
}

TaylorBridge BuildAddition(const TaylorBridge& lhs, const TaylorBridge& rhs)
{
    auto result = lhs.getTaylorType()+rhs.getTaylorType();
    return TaylorBridge(result);
}

TaylorBridge BuildAddition(const TaylorBridge& lhs, const double& rhs)
{
    auto result = lhs.getTaylorType()+rhs;
    return TaylorBridge(result);
}

TaylorBridge BuildAddition(const double& lhs, const TaylorBridge& rhs)
{
    auto result = lhs+rhs.getTaylorType();
    return TaylorBridge(result);
}

TaylorBridge BuildSubtraction(const TaylorBridge& lhs, const TaylorBridge& rhs)
{
    auto result = lhs.getTaylorType()-rhs.getTaylorType();
    return TaylorBridge(result);
}

TaylorBridge BuildSubtraction(const TaylorBridge& lhs, const double& rhs)
{
    auto result = lhs.getTaylorType()-rhs;
    return TaylorBridge(result);
}

TaylorBridge BuildSubtraction(const double& lhs, const TaylorBridge& rhs)
{
    auto result = lhs-rhs.getTaylorType();
    return TaylorBridge(result);
}

TaylorBridge BuildMultiplication(const TaylorBridge& lhs, const TaylorBridge& rhs)
{
    auto result = lhs.getTaylorType()*rhs.getTaylorType();
    return TaylorBridge(result);
}

TaylorBridge BuildMultiplication(const TaylorBridge& lhs, const double& rhs)
{
    auto result = lhs.getTaylorType()*rhs;
    return TaylorBridge(result);
}

TaylorBridge BuildMultiplication(const double& lhs, const TaylorBridge& rhs)
{
    auto result = lhs*rhs.getTaylorType();
    return TaylorBridge(result);
}

TaylorBridge BuildDivision(const TaylorBridge& lhs, const TaylorBridge& rhs)
{
    auto result = lhs.getTaylorType()/rhs.getTaylorType();
    return TaylorBridge(result);
}

TaylorBridge BuildDivision(const TaylorBridge& lhs, const double& rhs)
{
    auto result = lhs.getTaylorType()/rhs;
    return TaylorBridge(result);
}

TaylorBridge BuildDivision(const double& lhs, const TaylorBridge& rhs)
{
    auto result = lhs/rhs.getTaylorType();
    return TaylorBridge(result);
}

TaylorBridge sqrt(const TaylorBridge& value)
{
    return fadbad::sqrt(value.getTaylorType());
}

TaylorBridge sin(const TaylorBridge& value)
{
    return fadbad::sin(value.getTaylorType());
}

TaylorBridge cos(const TaylorBridge& value)
{
    return fadbad::cos(value.getTaylorType());
}

}
}
