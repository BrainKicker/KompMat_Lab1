function newton(f, n, startX, leftX, rightX, stepX, precision)
    arguments
        f(1,1) {sym}
        n(1,1) {mustBeInteger}
        startX(1,1) {mustBeNumeric}
        leftX(1,1) {mustBeNumeric}
        rightX(1,1) {mustBeNumeric}
        stepX(1,1) {mustBeNumeric}
        precision(1,1) {mustBeInteger}
    end

    % clear plot and hold
    clf
    hold on

    X = leftX:stepX:rightX;

    plot(X, f(X))

    syms df(x)

    df(x) = diff(f(x));

    Xi = zeros(1, n+1);

    Xi(1) = startX;

    fprintf("X0 = %f\n", Xi(1))

    for i = 1:n
        
        Xi(i+1) = Xi(i) - f(Xi(i))/df(Xi(i));
    
        fprintf("X%d = %.*f, delta = %.*f\n", i, precision, Xi(i+1), precision, Xi(i+1) - Xi(i))
    
        plot([Xi(i), Xi(i+1)], [f(Xi(i)), 0], "k")
        plot([Xi(i+1), Xi(i+1)], [0, f(Xi(i+1))], ":k")
    end

    % y = 0 horizontal line
    plot([leftX, rightX], [0, 0], "k")

    result = Xi(n+1);

    fprintf("result = %.*f +/- %.*f\n", precision, result, precision, abs(Xi(n+1) - Xi(n)))

    fprintf("\n")

    for i = 2:n+1
        fprintf("alpha%d = %.*f\n", i-1, precision, log(Xi(i) - result)/log(Xi(i-1) - result))
    end
end