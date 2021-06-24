function [AeroProps] = Aero(vehicle, n)
% Options: tiltwing, tiltrotor, compound, helicopter, lift+cruise, tiltduct

    AeroProps.f      =   1.03;
    
    if n==1
         if strcmpi(vehicle,'kitty')
                AeroProps.cd0      	=   0.015;
                AeroProps.FM      	=   0.8;
                AeroProps.LD     	=   18;
                AeroProps.K         =   0.55*1./(4.*AeroProps.cd0.*AeroProps.LD.^2); % I can prove this
                AeroProps.we_wmax   =   0.55;
                AeroProps.area_load =   80;
                AeroProps.disk_load =   80;
                AeroProps.Nprop    	=   0.92;
                AeroProps.Nmech    	=   0.92;
        end  
        
        if strcmpi(vehicle,'tiltwing')
                AeroProps.cd0      	=   mean([0.0148 0.0430]);
                AeroProps.FM      	=   mean([0.6 0.8]);
                AeroProps.LD     	=   mean([10 14]);
                AeroProps.K         =   1./(4.*AeroProps.cd0.*AeroProps.LD.^2); % I can prove this
                AeroProps.we_wmax   =   mean([0.55 0.65]);
                AeroProps.area_load =   mean([63 103]);
                AeroProps.disk_load =   mean([49 98]);
                AeroProps.Nprop    	=   mean([0.7 0.9]);
                AeroProps.Nmech    	=   mean([0.8 0.9]);
        end  
        
        if strcmpi(vehicle,'joby')
                AeroProps.cd0      	=   mean([0.0148 0.0430]);
                AeroProps.FM      	=   mean([0.6 0.8]);
                AeroProps.LD     	=   mean([17 19]);
                AeroProps.K         =   1./(4.*AeroProps.cd0.*AeroProps.LD.^2);
                AeroProps.we_wmax   =   mean([0.55 0.65]);
                AeroProps.area_load =   mean([63 103]);
                AeroProps.disk_load =   mean([49 98]);
                AeroProps.Nprop    	=   mean([0.7 0.9]);
                AeroProps.Nmech    	=   mean([0.8 0.9]);
        end 
        
        if strcmpi(vehicle,'tiltrotor')
                AeroProps.cd0      	=   mean([0.0148 0.0430]);
                AeroProps.FM      	=   mean([0.6 0.8]);
                AeroProps.LD     	=   mean([12 16]);
                AeroProps.K         =   1./(4.*AeroProps.cd0.*AeroProps.LD.^2);
                AeroProps.we_wmax   =   mean([0.55 0.65]);
                AeroProps.area_load =   mean([63 103]);
                AeroProps.disk_load =   mean([49 98]);
                AeroProps.Nprop    	=   mean([0.7 0.9]);
                AeroProps.Nmech    	=   mean([0.8 0.9]);
        end 
        
        if strcmpi(vehicle,'lift+cruise')
                AeroProps.cd0      	=   mean([0.0148 0.0430]);
                AeroProps.FM      	=   mean([0.6 0.8]);
                AeroProps.LD     	=   mean([8 12]);
                AeroProps.K         =   1./(4.*AeroProps.cd0.*AeroProps.LD.^2);
                AeroProps.we_wmax   =   mean([0.53 0.65]);
                AeroProps.area_load =   mean([63 103]);
                AeroProps.disk_load =   mean([49 98]);
                AeroProps.Nprop    	=   mean([0.7 0.9]);
                AeroProps.Nmech    	=   mean([0.8 0.9]);
        end 
        
        if strcmpi(vehicle,'tiltduct')
                AeroProps.cd0      	=   mean([0.0148 0.0430]);
                AeroProps.FM      	=   mean([0.6 0.8]);
                AeroProps.LD     	=   mean([8 12]);
                AeroProps.K         =   1./(4.*AeroProps.cd0.*AeroProps.LD.^2);
                AeroProps.we_wmax   =   mean([0.55 0.65]);
                AeroProps.area_load =   mean([63 103]);
                AeroProps.disk_load =   mean([146 244]);
                AeroProps.Nprop    	=   mean([0.7 0.9]);
                AeroProps.Nmech    	=   mean([0.8 0.9]);
        end 
        
        if strcmpi(vehicle,'compound')
                AeroProps.cd0      	=   mean([0.0148 0.0430]);
%                 AeroProps.Dq      	=   mean([0 0 ]);
                AeroProps.FM      	=   mean([0.6 0.8]);
                AeroProps.LD     	=   mean([7 11]);
                AeroProps.K         =   1./(4.*AeroProps.cd0.*AeroProps.LD.^2);
                AeroProps.we_wmax   =   mean([0.5 0.65]);
                AeroProps.area_load =   mean([63 103]);
                AeroProps.e         =   mean([0.5 0.8]);
                AeroProps.disk_load =   mean([15 29]);
                AeroProps.Nprop    	=   mean([0.7 0.9]);
                AeroProps.Nmech    	=   mean([0.8 0.9]);
        end 
        
        if strcmpi(vehicle,'helicopter')
%                 AeroProps.Dq      	=   mean([0 0 ]);
                AeroProps.FM      	=   mean([0.6 0.8]);
                AeroProps.LD     	=   mean([3.5 5]);
                AeroProps.K         =   1./(4.*AeroProps.cd0.*AeroProps.LD.^2);
                AeroProps.we_wmax   =   mean([0.43 0.55]);
                AeroProps.e         =   mean([0.5 0.8]);
                AeroProps.disk_load =   mean([15 29]);
                AeroProps.Nprop    	=   mean([0.7 0.9]);
                AeroProps.Nmech    	=   mean([0.8 0.9]);
        end 
        
        
        
    elseif n>1
        if strcmpi(vehicle,'tiltwing')
                AeroProps.cd0      	=   linspace(0.0148, 0.0430, n);
                AeroProps.FM      	=   linspace(0.6, 0.8, n);
                AeroProps.LD     	=   linspace(10, 14, n);
                AeroProps.K         =   1./(4.*AeroProps.cd0.*AeroProps.LD.^2);
                AeroProps.we_wmax   =   linspace(0.55, 0.65, n);
                AeroProps.area_load =   linspace(63, 103, n);
                AeroProps.disk_load =   linspace(49, 98, n);
                AeroProps.Nprop    	=   linspace(0.7, 0.9, n);
                AeroProps.Nmech    	=   linspace(0.8, 0.9, n);
        end  
        
        if strcmpi(vehicle,'tiltrotor')
                AeroProps.cd0      	=   linspace(0.0148, 0.0430, n);
                AeroProps.FM      	=   linspace(0.6, 0.8, n);
                AeroProps.LD     	=   linspace(12, 16, n);
                AeroProps.K         =   1./(4.*AeroProps.cd0.*AeroProps.LD.^2);
                AeroProps.we_wmax   =   linspace(0.55, 0.65, n);
                AeroProps.area_load =   linspace(63, 103, n);
                AeroProps.disk_load =   linspace(49, 98, n);
                AeroProps.Nprop    	=   linspace(0.7, 0.9, n);
                AeroProps.Nmech    	=   linspace(0.8, 0.9, n);
        end 
        
        if strcmpi(vehicle,'lift+cruise')
                AeroProps.cd0      	=   linspace(0.0148, 0.0430, n);
                AeroProps.FM      	=   linspace(0.6, 0.8, n);
                AeroProps.LD     	=   linspace(8, 12, n);
                AeroProps.K         =   1./(4.*AeroProps.cd0.*AeroProps.LD.^2);
                AeroProps.we_wmax   =   linspace(0.53, 0.65, n);
                AeroProps.area_load =   linspace(63, 103, n);
                AeroProps.disk_load =   linspace(49, 98, n);
                AeroProps.Nprop    	=   linspace(0.7, 0.9, n);
                AeroProps.Nmech    	=   linspace(0.8, 0.9, n);
        end 
        
        if strcmpi(vehicle,'tiltduct')
                AeroProps.cd0      	=   linspace(0.0148, 0.0430, n);
                AeroProps.FM      	=   linspace(0.6, 0.8, n);
                AeroProps.LD     	=   linspace(8, 12, n);
                AeroProps.K         =   1./(4.*AeroProps.cd0.*AeroProps.LD.^2);
                AeroProps.we_wmax   =   linspace(0.55, 0.65, n);
                AeroProps.area_load =   linspace(63, 103, n);
                AeroProps.disk_load =   linspace(146, 244, n);
                AeroProps.Nprop    	=   linspace(0.7, 0.9, n);
                AeroProps.Nmech    	=   linspace(0.8, 0.9, n);
        end 
        
        if strcmpi(vehicle,'compound')
                AeroProps.cd0      	=   linspace(0.0148, 0.0430, n);
%                 AeroProps.Dq      	=   linspace(0 0 );
                AeroProps.FM      	=   linspace(0.6, 0.8, n);
                AeroProps.LD     	=   linspace(7, 11, n);
                AeroProps.K         =   1./(4.*AeroProps.cd0.*AeroProps.LD.^2);
                AeroProps.we_wmax   =   linspace(0.5, 0.65, n);
                AeroProps.area_load =   linspace(63, 103, n);
                AeroProps.e         =   linspace(0.5, 0.8, n);
                AeroProps.disk_load =   linspace(15, 29, n);
                AeroProps.Nprop    	=   linspace(0.7, 0.9, n);
                AeroProps.Nmech    	=   linspace(0.8, 0.9, n);
        end 
        
        if strcmpi(vehicle,'helicopter')
%                 AeroProps.Dq      	=   linspace(0 0 );
                AeroProps.FM      	=   linspace(0.6, 0.8, n);
                AeroProps.LD     	=   linspace(3.5, 5, n);
                AeroProps.K         =   1./(4.*AeroProps.cd0.*AeroProps.LD.^2);
                AeroProps.we_wmax   =   linspace(0.43, 0.55, n);
                AeroProps.e         =   linspace(0.5, 0.8, n);
                AeroProps.disk_load =   linspace(15, 29, n);
                AeroProps.Nprop    	=   linspace(0.7, 0.9, n);
                AeroProps.Nmech    	=   linspace(0.8, 0.9, n);
        end 

    else
        error('n must be at least 1')
    end
end

    
    