function dummy = ComplexPlot(t, data)

%figure()
plot(t, real(data));
hold on;
plot(t, imag(data),'g');
hold off;

dummy = 0;

end

