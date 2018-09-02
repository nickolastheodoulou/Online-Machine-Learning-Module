data_matrix = dlmread("tennis1.txt");%load in the data into a matrix
tennis_data(:,1) = data_matrix(:,4);
tennis_data(:,2) = data_matrix(:,6);
tennis_data(:,3) = data_matrix(:,8);
tennis_data(:,4) = data_matrix(:,10);%create a new matrix of the 4 columns actually used

weights = [0.25,0.25,0.25,0.25];%initialise weights


    length_tennis_data = length(tennis_data);%used to define length of loops
    length_weights = length(weights);
    sum_weights=0;%initialise the sum of the weights to zero
    g_0=0;%initialise gammas
    g_1=0;
    ita = 2;%set ita to 2
    p =zeros(1,length_weights);%initialize the p matrix 
    gamma=zeros(length_tennis_data,1);%initialize gamma vector which is what is calculated using the AA
    
for t = 1:length_tennis_data
    

    for n = 1:length(weights)
       sum_weights = sum_weights + weights(n);%sum the weights on each iteration
    end

    for n = 1:length(weights)
        p(n) = weights(n)/sum_weights;%normalise the distribution using the expert on each iteration
    end
    
    for n = 1:length(weights)
    g_0= g_0 + (p(n)) * exp(-ita*(tennis_data(t,n)^2));%calculate the summation in the g(0) and g(1)
    %equation fist
    g_1= g_1 + (p(n)) * exp(-ita*(1-tennis_data(t,n)^2));
    end
    
    g_0=(-1/ita) * log(g_0);%calculate g(0) and g(1)
    g_1=(-1/ita) * log(g_1);
    
    gamma(t)=0.5-((0.5)*(g_1-g_0));%calculate gamma for each iteration
    
    
    for n = 1:length(weights)
        weights(n)=weights(n)*exp((-ita*(1-tennis_data(t,n)^2)));%update the weights for the next iteration
    end
    
    g_0=0;%set g(0) to zero so that this can be calculated each iteration
    g_1=0;
    sum_weights=0;%set sum of weight to zero so that they can be normalised correctly
    
end
    