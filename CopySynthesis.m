function copy_synthesis_ok = CopySynthesis(input_directory, file_list, output_directory)
% CopySynthesis -- Sample function how to use component functions for copy
% synthesis
%
% copy_synthesis_ok = CopySynthesis(file_list, out_directory)
%
% Arguments
%   input_directory : path to input files
%   file_list : structure variable generated by dir() and edited
%   output_directory : output directory path
%
% Return value
%   copy_synthesis_ok : true if copy synthesis succeded

% Copyright 2016 Google Inc. All Rights Reserved
% Author: hidekik@google.com (Hideki Kawahara)

n_files = length(file_list);
assert(n_files > 0);
mkdir(output_directory);
for ii = 1:n_files
  file_name = file_list(ii).name;
  [x_original, fs_original] = AudioRead([input_directory file_name]);
  % Analysis of source informaton and spectrum then synthesize
  source = AnalyzeSpeechSource(x_original, fs_original);
  spectra = ...
    AnalyzeSpeechSpectra(x_original, fs_original, ...
    source.f0, ...
    source.frame_time);
  y = SynthesizeSpeech(spectra, source);
  y = y/max(abs(y)) * 0.9;
  AudioWrite([output_directory file_name], y, fs_original);
end;
copy_synthesis_ok = true;
end

