/*
 * $Id: f4arr3.cpp 542 2012-07-10 21:04:06Z johnoel $
 *
 * Author: David Fournier
 * Copyright (c) 2008-2012 Regents of the University of California 
 */
/**
 * \file
 * Description not yet available.
 */
#include "fvar.hpp"
#include <d4arr.hpp>

/**
 * Description not yet available.
 * \param
 */
dvar4_array::dvar4_array() 
{
  allocate();
}

/**
 * Description not yet available.
 * \param
 */
void dvar4_array::allocate(void)
{
  shape=NULL;
  t = NULL;
}
