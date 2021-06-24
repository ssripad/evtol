function [MissionProps] = Mission(config,n)
    % Options: conventional, VTOL
    if n==1
        if strcmpi(config,'VTOL')
            % Assign Vertical Climb Variables
            MissionProps.VC     =   0.5; % Vertical Climb Velocity (m/s) NASA
            MissionProps.H0     =   15;  % Vertical Take-Off AGL  NASA
            % Assign Hover / Transition from Vertical Variables
            MissionProps.tup    =   120; % Hover Up Time (s) 90 vahana, 120 mi
            % Assign Aircraft Climb Variables
            MissionProps.Vv     =   4.3; % Climb Rate (m/s) NASA paper
            % Assign Cruise Variables
%             MissionProps.Range  =   200000; % m 
            MissionProps.Hc     =   750; % Cruise AGL
            % Assign Descent Variables
            MissionProps.VD     =   1.4; % Aircraft Descent Rate (m/s)
            % Assign Hover / Transition from Aircraft Flight Variables
            MissionProps.tdn    =   120; % Hover Down Time (s) 90 vahana, 120 mit
            % Assign Vertical Descent Variables
            MissionProps.VDVL   =   0.4; % Vertical Descent Velocity (m/s) NASA
            % Assign Reserve Variables
            MissionProps.Hr     =   300; % Reserve AGL
            MissionProps.tr     =   45*60;% Reserve time [s] FAR 23  
        end
        %% Do for conventional mission eventually
%         if strcmpi(config,'VTOL')

%         end
        
    elseif n>1
        if strcmpi(config,'VTOL')
            % Assign Vertical Climb Variables
            MissionProps.VC     =   0.5; % Vertical Climb Velocity (m/s) NASA
            MissionProps.H0     =   linspace(5,25,n);  % Vertical Take-Off AGL  NASA
            % Assign Hover / Transition from Vertical Variables
            MissionProps.tup    =   linspace(90,150,n); % Hover Up Time (s) 90 vahana, 120 mi
            % Assign Aircraft Climb Variables
            MissionProps.Vv     =   4.5; % Climb Rate (m/s) NASA paper
            % Assign Cruise Variables
%             MissionProps.Range  =   linspace(32000, 368000, n);
            MissionProps.Hc     =   linspace(300, 1200, n); % Cruise AGL
            % Assign Descent Variables
            MissionProps.VD     =   1.5; % Aircraft Descent Rate (m/s)
            % Assign Hover / Transition from Aircraft Flight Variables
            MissionProps.tdn    =   linspace(90,150,n); % Hover Down Time (s) 90 vahana, 120 mit
            % Assign Vertical Descent Variables
            MissionProps.VDVL   =   0.5; % Vertical Descent Velocity (m/s) NASA
            % Assign Reserve Variables
            MissionProps.Hr     =   linspace(150, 450, n); % Reserve AGL
            MissionProps.tr     =   linspace(0, 45*60, n);% Reserve time FAR 23  
        end                 
    else
        error('n must be at least 1')
    end      
end
