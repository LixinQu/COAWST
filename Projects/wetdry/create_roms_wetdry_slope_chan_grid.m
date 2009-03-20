% create_roms_grid.m
%
% input:         See below.
% output:        Netcdf roms grid.
%
% This is intended to be a simple roms grid, typically
% rectilinear. For more complicated grids use seagrid of
% something else.
%
% jcwarner 21Feb2009
%

%%%%%%%%%%%%% START OF USER SECTION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Select your app and then fill in steps 2-7 for that application.
% Required values are :
% x, y, dx, dy, depth, angle, mask, f, and file name.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%1) set your case here to = 1.
WET_DRY_SLOPE_CHAN=1;
MY_APP=0;

if (WET_DRY_SLOPE_CHAN)
  %2) enter x and y coordinates of rho points
    ncellsx=102;  dx=250;
    ncellsy=6;    dy=200;
    x=[-dx/2:dx:dx*(ncellsx-1)];
    y=[-dy/2:dy:dy*(ncellsy-1)];
  % 
    x=repmat(x,length(y),1);
    y=repmat(y',1,length(x));
  %3) set depth 
    depth=10*x/25250;
  %4) set grid angle
    roms_angle=zeros(size(depth));
  %5) set masking
    mask_rho=ones(size(depth));
  %6) set coriolis f
    f=zeros(size(depth));
  %7) enter output file name
    fname='wetdry_slope_chan_grd.nc';
elseif (MY_APP)
  disp('set MY_APP=1 and then put your stuff in here')
end

%%%%%%%%%%%%% END OF USER SECTION %%%%%%%%%%%%%%%%

%create roms grid
  rho.x=x;
  rho.y=y;  
  rho.dx=dx;
  rho.dy=dy;
  rho.depth=depth;
  rho.angle = roms_angle;
  rho.mask = mask_rho
  rho.f = f;
  projection='mercator';
  save temp_jcw33.mat
  eval(['mat2roms_jcw(''temp_jcw33.mat'',''',fname,''');'])
  !del temp_jcw33.mat
  disp(['Created roms grid -->   ',fname])


