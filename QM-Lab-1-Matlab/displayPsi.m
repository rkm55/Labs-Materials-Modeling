function displayPsi(axHandle,evenodd,psi,i,x,energy,iter,maxIter)
% displayPsi - plotting function that illustrates evolution of the wave
%              vector solution with iterative updates
%   axHandle - MATLAB axes handle so plots end up on same axis
%   evenodd - 1 or -1 or even or odd solutions respectively - required
%             since solution is only over the half space
%   psi - wave function solution
%   energy - energy value corresponding to current wave function solution
%   iter - number of the iteration
%   maxIter - max allowed iteration
%
% Modeling Materials (ME EN 556) - QM Lab 1
    
    %persistent variables to simplify this function
    persistent lastHandle cmap
    
    if isempty(cmap) || isempty(colormap(axHandle)) || length(cmap(:,1)) ~= maxIter
        %create colormap if it doesn't exist
        cmap=colormap(hsv(maxIter));
    end
    
    
    if ~isempty(lastHandle) && ishandle(lastHandle)
        %update the color of the last guess according to the colormap
        ii=iter;
        if ii> maxIter %can't exceed the cmap length
            ii=maxIter;
        end
        set(lastHandle,'linestyle',':','color',cmap(ii,:))
    end
    
    %update title with current energy
    title(axHandle,sprintf('Energy: %f',energy))
    
    %plot new wave function (including for x<0) and save handle for future
    %update
    lastHandle=plot(axHandle,[-x(i:-1:1),x(1:i)],[evenodd*psi(i:-1:1),psi(1:i)],'k-');
    
    %bring figure to front and pause before continuing
    shg
    pause(.1) %this value can be edited for faster/slower evolution

end
