clc; clear all; close all

load step10_ditance_matrix_grid_40_from_aggregation.mat distance_matrix
groups = nchoosek(1:size(distance_matrix,1),3);

%% PSO initialization
swarm_size = 70;                       % number of the swarm particles
maxIter    = 150;                      % maximum number of iterations
inertia    = 0.93;
c_local    = 0.4;                       
c_global   = 0.3;
plotswarm  = 1;                        % 1 for plot swarm behavior

%% Set the position of the initial swarm
swarm     = datasample(groups,swarm_size,'Replace',false);
velocity  = zeros(swarm_size,3);        % set initial velocity for particles
fitness   = inf*ones(swarm_size,1);     % set the best value so far
P_best    = swarm;
G_best    = swarm(1,:);
g_fitness = inf;
fval      = inf*ones(swarm_size,1);
tic;
%% The main loop of PSO
for iter = 1:maxIter
    swarm = swarm + velocity;          % update position with the velocity
    swarm(swarm < 1)   = 1;            % constrain
    swarm(swarm > 725) = 725;          % constrain

    %% define the objective funcion 

    %% compare the function values to find the best ones
    for i = 1:swarm_size
        if fval(i) < fitness(i)
            P_best(i,:) = swarm(i,:);  % update best position,
            fitness(i)  = fval(i);     % update the best value so far
        end
    end
    %% find the best function value in total
    [mini, gbest] = min(fitness);      
    if g_fitness >= mini
        G_best    = swarm(gbest,:);
        g_fitness = mini;  
    end
    %% update the velocity of the particles

    %% Plot
    if plotswarm == 1
        fig = gcf;
        fig.PaperUnits = 'centimeters';
        fig.PaperPosition = [0 0 10 4];
        p1 = scatter3(swarm(:,1),swarm(:,2),swarm(:,3),'x');hold on
        p2 = scatter3(170,363,542,'MarkerFaceColor',[1 0 0]);
        p3 = scatter3(swarm(gbest,1),swarm(gbest,2),swarm(gbest,3),...
            'MarkerFaceColor',[0 1 0]);hold off
        axis([1 725 1 725 1 725]);
        title('Swarm behavior')
        xlabel("Rescue ship 1")
        ylabel("Rescue ship 2")
        zlabel("Rescue ship 3")
        lgd = legend([p1,p2,p3], {'Swarm', 'Optimum', 'G_{best}'});
        lgd.Location = 'northeast';
        pause(.1); 
        
        drawnow
        frame = getframe(1);
        im    = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);
        if iter == 1
            imwrite(imind,cm,'animation.gif','gif', 'Loopcount',inf);
        else
            imwrite(imind,cm,'animation.gif','gif','WriteMode','append');
        end
    end
    fprintf('iteration: %i, global fitness = %f\n', iter, mini);
end
toc
fprintf("G_best = [%i %i %i]\t with fitness = %i\n",...
    G_best(1),G_best(2),G_best(3), g_fitness)
fprintf("Optimal = [%i %i %i]\t with fitness = %i\n",...
    170, 363, 542, 3.1678e+03);