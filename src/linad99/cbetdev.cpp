/*
 * $Id: cbetdev.cpp 542 2012-07-10 21:04:06Z johnoel $
 *
 * Author: David Fournier
 * Copyright (c) 2008-2012 Regents of the University of California
 */
/**
 * \file
 * Description not yet available.
 */
#include <fvar.hpp>

/**
 * Description not yet available.
 * \param
 */
double beta_deviate(double a,double b,double x,double eps)
{
  double y=cumd_norm(x);
  y=.9999999*y+.00000005;
  double z=inv_cumd_beta_stable(a,b,y,eps);
  return z;
}
