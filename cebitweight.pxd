"""BitWeight Python wrapper."""

from libcpp cimport bool


cdef extern from "ebitweight.h" namespace "bitweight" nogil:

  cdef cppclass BitWeight:

    BitWeight(const BitWeight &)
    BitWeight(double)

    double real()
    double loge()
	

    bool operator<(BitWeight)
    bool operator==(BitWeight)

    # These operators are not yet overloadable, but we can hack around it.
    BitWeight &iadd "operator+="(BitWeight)
    BitWeight &imul "operator*="(BitWeight)
    BitWeight &idiv "operator/="(BitWeight)

    BitWeight operator+(BitWeight)
    BitWeight operator*(BitWeight)
    BitWeight operator/(BitWeight)
