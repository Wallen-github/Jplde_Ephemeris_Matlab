function [position, velocity, acceleration, error]=read_Bin(T,center,target)
% This function is a exaple to read the JPL planetary ephemeris DE 405
% and give the position and velocity of the target object with respect 
% to the center object.
% 
% 
% short int read_Bin (double T, short int target,
%                             short int center)
%
% ------------------------------------------------------------------------
% 
%    PURPOSE:
%       This function accesses the JPL planetary ephemeris to give the
%       position and velocity of the target object with respect to the
%       center object.
% 
%    REFERENCES:
%       Hai-Shuo Wang(2020). "The JPL Export
%          Planetary Ephemeris"; JPL document dated 11 July 2020.
% 
%    INPUT
%    ARGUMENTS:
%       T (double)
%          Two-element array containing the Julian date, 
%       target (short int)
%          Number of 'target' point.
%       center (short int)
%          Number of 'center' (origin) point.
%          The numbering convention for 'target' and'center' is:
%             1 = Mercury           8 = Neptune
%             2 = Venus             9 = Pluto
%             3 = Earth            10 = Moon
%             4 = Mars             11 = Sun
%             5 = Jupiter          12 = Solar system bary.
%             6 = Saturn           13 = Earth-Moon bary.
%             7 = Uranus           14 = Nutations (long int. and obliq.)
%                                  15 = Librations
%                                  16 = Lunar Euler angle rates
%                                  17 = TT-TDB
%             (If nutations are desired, set 'target' = 14;
%              'center' should be zero.)
% 
%    OUTPUT
%    ARGUMENTS:
%       *position (double)
%          Position vector array of target relative to center, measured
%          in AU or km.
%          Nutations returned in longitude (1) and obliquity (2) in radians
%          Librations returned in radians
%       *velocity (double)
%          Velocity vector array of target relative to center, measured
%          in AU/day or km/sec.
%          Nutations rate returned in longitude (1) and obliquity (2) in
%          radians/day or radians/sec
%          Librations rate returned in radians/day or radians/sec
%       *acceleration (double)
%          acceleration vector array of target relative to center, measured
%          in AU/day^2 or km/sec^2.
%          Nutations rate returned in longitude (1) and obliquity (2) in
%          radians/day^2 or radians/sec^2
%          Librations rate returned in radians/day^2 or radians/sec^2
% 
%    RETURNED
%    VALUE:
%       (short int)
%          0  ...everything OK.
%          1,2...error returned from State.
% 
%    GLOBALS
%    USED:
%       EM_RATIO          eph_manager.h
% 
%    FUNCTIONS
%    CALLED:
%       state             eph_manager.h
% 
%    VER./DATE/
%    PROGRAMMER:
%       V1.0/03-93/WTH (USNO/AA): Convert FORTRAN to C.
%       V1.1/07-93/WTH (USNO/AA): Update to C standards.
%       V2.0/07-98/WTH (USNO/AA): Modified for ease of use and linearity.
%       V3.0/11-06/JAB (USNO/AA): Allowed for use of input 'split' Julian
%                                 date for higher precision.
%       V3.1/11-07/WKP (USNO/AA): Updated prolog and error codes.
%       V3.1/12-07/WKP (USNO/AA): Removed unreferenced variables.
%       V3.2/10-10/WKP (USNO/AA): Renamed function to lowercase to
%                                 comply with coding standards.
% 
%    NOTES:
%       None.
% 
% ------------------------------------------------------------------------

%初始化类. 参数：历表序号
s=Ephem('405');

% 将ASCII文件转换为二进制文件
Ephem.asc2eph('405','ascp2000.405','JPLEPH2000');

% 设置常数
setDEConstants(s,'405');

% 打开二进制文件
openDEeph(s,'405','JPLEPH');

%读取天体位置
[position, velocity, acceleration, error] = planet_ephemeris(s,T,center,target);

end

