
m=[0   1/3 0   1/3 0; %r
   1/2 0   1/2 0   0; %o
   0   1/3 0   1/3 0; %m
   1/2 0   1/2 0   0; %a
   0   1/3 0   1/3 0]; %.

wordnumb=crawl(m,1,5);
basedados= ["r","o","m","a","."];

for i=1: 10e5
    wordnumb=crawl(m,1,5);
    y{i}=basedados(wordnumb);
end

for i=1: 10e5
    for u=i+1: 10e5
        if(y{i}== y{u})
            a{j}=
        end
    end
end    













% Random walk on the Markov chain
% Inputs:
% H - state transition matrix
% first - initial state
% last - terminal or absorving state
function state = crawl(H, first, last)
% the sequence of states will be saved in the vector "state"
% initially, the vector contains only the initial state:
    state = [first];
% keep moving from state to state until state "last" is reached:
    while (1)
        state(end+1) = nextState(H, state(end));
        if (state(end) == last)
            break;
        end
    end
end
% Returning the next state
% Inputs:
% H - state transition matrix
% currentState - current state
function state = nextState(H, currentState)
% find the probabilities of reaching all states starting at the current one:
probVector = H(:,currentState); % probVector is a row vector
n = length(probVector); %n is the number of states
% generate the next state randomly according to probabilities probVector:
state = discrete_rnd(1:n, probVector);
end
% Generate randomly the next state.
% Inputs:
% states = vector with state values
% probVector = probability vector
function state = discrete_rnd(states, probVector)
    U=rand();
    i = 1 + sum(U > cumsum(probVector));
    state= states(i);
end
