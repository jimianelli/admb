// Orange data used in Millar (2004) Aust NZ J. Stat Vol 46, p. 543-554.

DATA_SECTION

  init_int n			// Number of data points
  init_vector y(1,n)		// Response vector
  init_vector t(1,n)		// Primary covariate
  init_int M			// Number of groups		
  init_vector ngroup(1,M)	// Number in each group
  init_int m			// Number of parameters in nonlinear regression model		

PARAMETER_SECTION

  init_bounded_vector beta(1,3,-50,200,1)		// Fixed effects parameters
  init_bounded_number log_sigma(-5.0,5.0,1)		// log(residual variance)
  init_bounded_number log_sigma_u(-5,5,2)		// 0.5*log(variance component)
  init_bounded_number log_sigma_v(-5,5,2)		// 0.5*log(variance component)

  random_effects_vector u(1,M,2)			// Unscaled random effects
  random_effects_vector v(1,7,2)

  objective_function_value g

PRELIMINARY_CALCS_SECTION

  cout << setprecision(4);

GLOBALS_SECTION

  #include <df1b2fun.h>

PROCEDURE_SECTION

  int i,ii,j;

  dvar_vector a(1,3);		  		// Basic model function parameters
  dvariable tmp, f;
  dvariable sigma = mfexp(log_sigma);

  a(1) = 192.0 + beta(1);			
  a(2) = 726.0 + beta(2);
  a(3) = 356.0 + beta(3);

  g = 0.0;

  ii=0;

  for(i=1;i<=(int) M;i++)
  {

    for(j=1;j<=ngroup(i);j++)
    {
      ii++;
      g -= -log_sigma;
      f = (a(1)+u(i)+v(j))/(1+mfexp(-(t(ii)-a(2))/a(3)));
      tmp = y(ii) - f;
      tmp /= sigma;
      g -= -0.5*tmp*tmp;

    }

  }

// Random effect contribution from u

  for(i=1;i<=M;i++)

  {    
    g -= -(log_sigma_u);
    g -= -.5*(square(u(i)/mfexp(log_sigma_u)));
  }

// Random effects contribution from v

  for(j=1;j<=7;j++)
  {
    g -= -(log_sigma_v);
    g -= -.5*(square(v(j)/mfexp(log_sigma_v)));
  }


REPORT_SECTION


  //report << beta0+beta << endl;
  report << exp(log_sigma) << endl;
  report << exp(log_sigma_u) << endl;
  report << exp(log_sigma_v) << endl;


TOP_OF_MAIN_SECTION

  arrmblsize = 40000000L;
  gradient_structure::set_GRADSTACK_BUFFER_SIZE(3000000);
  gradient_structure::set_CMPDIF_BUFFER_SIZE(200000);
  gradient_structure::set_MAX_NVAR_OFFSET(10000);

