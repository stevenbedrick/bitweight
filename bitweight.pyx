"""BitWeight Python wrapper."""

from libcpp cimport bool
from cython.operator cimport dereference as deref


cdef extern from "bitweight.h" namespace "bitweight" nogil:

  cdef cppclass BitWeight:

    BitWeight(const BitWeight &)
    BitWeight(double)
    BitWeight(double, double)

    double real()

    bool operator<(BitWeight)
    bool operator==(BitWeight)

    # These operators are not yet overloadable, but we can hack around it.
    BitWeight &iadd "operator+="(BitWeight)
    BitWeight &imul "operator*="(BitWeight)
    BitWeight &idiv "operator/="(BitWeight)

  BitWeight operator+(BitWeight, BitWeight)
  BitWeight operator*(BitWeight, BitWeight)
  BitWeight operator/(BitWeight, BitWeight)


cdef class PywrapBitWeight(object):

  cdef BitWeight *ptr

  def __init__(self, double n, double d=1.):
    # These assertions have to be repeated as Cython ignores C++ assertions.
    assert n >= 0.
    assert d > 0.
    self.ptr = new BitWeight(n) if d == 1. else new BitWeight(n, d)

  def __dealloc__(self):
    del self.ptr

  def real(self):
    return self.ptr.real()
   
  # Overloads.

  def __iadd__(self, PywrapBitWeight rhs):
    self.ptr.iadd(deref(rhs.ptr))
    return self 

  def __imul__(self, PywrapBitWeight rhs):
    self.ptr.imul(deref(rhs.ptr))
    return self

  def __idiv__(self, PywrapBitWeight rhs):
    self.ptr.idiv(deref(rhs.ptr))
    return self

  def __add__(PywrapBitWeight lhs, PywrapBitWeight rhs):
    cdef PywrapBitWeight result = PywrapBitWeight.__new__(PywrapBitWeight)
    result.ptr = new BitWeight(deref(lhs.ptr) + deref(rhs.ptr))
    return result
 
  def __mul__(PywrapBitWeight lhs, PywrapBitWeight rhs):
    cdef PywrapBitWeight result = PywrapBitWeight.__new__(PywrapBitWeight)
    result.ptr = new BitWeight(deref(lhs.ptr) * deref(rhs.ptr))
    return result

  def __div__(PywrapBitWeight lhs, PywrapBitWeight rhs):
    cdef PywrapBitWeight result = PywrapBitWeight.__new__(PywrapBitWeight)
    result.ptr = new BitWeight(deref(lhs.ptr) / deref(rhs.ptr))
    return result

  def __richcmp__(PywrapBitWeight lhs, PywrapBitWeight rhs, int op): 
    if op == 0:
      return deref(lhs.ptr) < deref(rhs.ptr)
    elif op == 2:
      return deref(lhs.ptr) == deref(rhs.ptr)
    elif op == 3:
      return not deref(lhs.ptr) == deref(rhs.ptr)
    raise NotImplemented("Operator {} not implemented.".format(op))