%% Correlation Method Example / Sanity Check
% * Justin Pearson
% * ECE 147C
% * 2014.04.06

%%
% You should run ece147c_lab0_v3.mdl (in the same dir as this file) before
% running this file. The simulation produces variables: encoders,
% motor_cmd, trigger_signal. 

assert( exist('encoders','var') && exist('motor_cmd','var') && exist('trigger_signal','var') )

%% Compute intermediate vars

u     = motor_cmd.signals.values(:,1);
y     = encoders.signals.values(:,2);
T     = length(y); % number of samples
Omega = 2*pi*0.001; % sine block into motor_cmd has freq 2pi rad/sec & 0.001 sec/sample; Omega is in rad/sample
a     = 2; % amplitude of the motor_cmd sine wave block

%%
% Your input u should be a cosine, ie, its first element should be its
% amplitude.
assert( abs(u(1)-a) < 1e-3 ) % roughly

%% Correlation method
% From the notes, for a fixed $\Omega \in [0,\pi]$ and given data $y(k) \in
% R, k=1,\ldots,T$, the relationship between $y$ and the transfer function
% $H$ is
% 
% $$K_\Omega := \frac{1}{T} \sum_{k=1}^T e^{-j \Omega k} y(k) = \frac{\alpha}{2} H(e^{j \Omega})$$

x=exp(-i*Omega*[1:T]);
K = 1/T*(x*y)
H = K*2/a

%%
% That value of $H$ is one point on the bode plot. It has magnitude and
% phase
abs(H) % gain (unitless)
angle(H) % phase shift (rad)

%% Sanity check: Gain
% Estimate how much the plant amplified u to y, and compare it to the gain
% at this frequency $H(e^{j \Omega})$.

figure
subplot(2,1,1); plot(u)
subplot(2,1,2); plot(y)

%%
% Looks like about a swing of 4 for u and 2900 for y, hence:
2900/4

%% 
% Pretty close to abs(H).


%% Sanity check: Phase
% Looking at the plot, it looks like u hits a peak at sample 8000 and y
% hits a peak at 8350. Hence the phase should something like
- 350 * Omega % 350 samp * Omega rad/samp

%%
% Pretty close to angle(H).

%%
% Could we have done better by throwing away the initial transient?
% Be careful to throw away starting at an index where u is at its peak
% (still a cosine)!

y = y(3000:end);
T = length(y); 
x=exp(-i*Omega*[1:T]);
K = 1/T*(x*y)
H = K*2/a
abs(H)
angle(H)

%%
% Not a big improvement. Our initial test was pretty long. If it had been
% shorter, we might've gained more from tossing the initial data.
