function createRecursiveDir(targetPath)
    % createRecursiveDir Recursively creates directories for a given path
    % This function takes a single input argument, targetPath, which is a string
    % representing the full path where directories need to be created. The function
    % checks each part of the path and creates the directory if it does not exist.
    %
    % Example usage:
    % createRecursiveDir('C:\Users\Example\new\path\folders');
    % createRecursiveDir('/Users/Example/new/path/folders');
    %
    % Inputs:
    %   targetPath - A string specifying the full path to create. It should be
    %                formatted according to the operating system's file path
    %                conventions.
    %
    % Outputs:
    %   None. Directories are created on the disk.

    % Split the targetPath into parts using the file separator specific to the
    % operating system (filesep ensures cross-platform compatibility).
    
    % @keevinzha
    pathParts = strsplit(targetPath, filesep);

    % Start building the path from the first part, which is typically a drive
    % letter or root directory in UNIX/Linux.
    currentPath = pathParts{1};

    % Loop through each part of the path starting from the second part
    % because the first part is already included in currentPath.
    for k = 2:length(pathParts)
        % Build the current path incrementally
        currentPath = fullfile('/',currentPath, pathParts{k});

        % Check if the current path directory exists
        if ~exist(currentPath, 'dir')
            % Directory does not exist, create it
            mkdir(currentPath);
        end
    end
end

