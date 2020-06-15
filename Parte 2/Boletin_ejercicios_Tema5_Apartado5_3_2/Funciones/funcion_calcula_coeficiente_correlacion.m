function coef_corr = funcion_calcula_coeficiente_correlacion(mCov)

    sigma1 = sqrt(mCov(1,1));
    sigma2 = sqrt(mCov(2,2));
    
    coef_corr = mCov(1,2)/(sigma1*sigma2);

end

