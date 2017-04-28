"""Tests of the BitWeight Python wrapper."""

from __future__ import division

import unittest
import math

from ebitweight import BitWeight, BitWeightRangeError


class TestBitWeight(unittest.TestCase):

  def setUp(self):
    self.one = BitWeight(1)
    
    self.one_num = BitWeight(50)
    self.sec_num = BitWeight(30)

  def testAddition(self):
    # logadd
    add = (self.one_num + self.sec_num).real()
    self.assertEqual((self.sec_num + self.one_num).loge(), -math.log(add))

  def testMultiplication(self):
    # addition in log domain
    mult = self.one_num * self.sec_num
    self.assertEqual(mult.loge(), 80)
    self.assertAlmostEqual(mult.real(), math.pow(math.e,-mult.loge()))
    
  def testDivision(self):
    # subtraction in log domain
    divide = self.one_num / self.sec_num
    self.assertEqual(divide.loge(), 20)
    self.assertAlmostEqual(divide.real(), math.pow(math.e,-divide.loge()))

  def testComparison(self):
    self.assertEqual(self.one.real(), 0.36787944117144233)


if __name__ == "__main__":
  unittest.main()
