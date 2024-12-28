//
//  TaylorBridge.hpp
//  FADBADSwift
//
//  Created by Leonard Chan on 12/27/24.
//

#ifndef TaylorBridge_hpp
#define TaylorBridge_hpp

#include "tadiff.h"

namespace fadbad {

namespace bridge {

using TDB = fadbad::T<double>;

class TaylorBridge
{
public:
    TaylorBridge(const double& value);
    TaylorBridge(const TDB& value);
    
    const TDB& getTaylorType() const;
    
    const double getSubscriptValue(const int& index);
    void setSubscriptValue(const int& index, const double& value);
    
    unsigned int eval(const unsigned int& i);
    
private:
    TDB m_taylorType;
};

TaylorBridge BuildAddition(const TaylorBridge& lhs, const TaylorBridge& rhs);
TaylorBridge BuildAddition(const TaylorBridge& lhs, const double& rhs);
TaylorBridge BuildAddition(const double& lhs, const TaylorBridge& rhs);

TaylorBridge BuildSubtraction(const TaylorBridge& lhs, const TaylorBridge& rhs);
TaylorBridge BuildSubtraction(const TaylorBridge& lhs, const double& rhs);
TaylorBridge BuildSubtraction(const double& lhs, const TaylorBridge& rhs);

TaylorBridge BuildMultiplication(const TaylorBridge& lhs, const TaylorBridge& rhs);
TaylorBridge BuildMultiplication(const TaylorBridge& lhs, const double& rhs);
TaylorBridge BuildMultiplication(const double& lhs, const TaylorBridge& rhs);

TaylorBridge BuildDivision(const TaylorBridge& lhs, const TaylorBridge& rhs);
TaylorBridge BuildDivision(const TaylorBridge& lhs, const double& rhs);
TaylorBridge BuildDivision(const double& lhs, const TaylorBridge& rhs);

TaylorBridge sqrt(const TaylorBridge& value);
TaylorBridge sin(const TaylorBridge& value);
TaylorBridge cos(const TaylorBridge& value);

}

}


#endif /* TaylorBridge_hpp */
