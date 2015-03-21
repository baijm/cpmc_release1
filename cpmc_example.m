function cpmc_example()  
    addpath('./code/');    
    addpath('./external_code/');
    addpath('./external_code/paraFmex/');
    addpath('./external_code/imrender/vgg/');
    addpath('./external_code/immerge/');
    addpath('./external_code/color_sift/');
    addpath('./external_code/vlfeats/toolbox/kmeans/');
    addpath('./external_code/vlfeats/toolbox/kmeans/');
    addpath('./external_code/vlfeats/toolbox/mex/mexa64/');
    addpath('./external_code/vlfeats/toolbox/mex/mexglx/');
    addpath('./external_code/globalPb/lib/');
    addpath('./external_code/mpi-chi2-v1_5/');        
    
    % create multiple threads (set how many you have)
    % N_THREADS = 8;
    N_THREADS = 2;
    if(matlabpool('size')~=N_THREADS)
        matlabpool('open', N_THREADS);
    end

    exp_dir = './data/';
    %img_name = '2010_000238'; % airplane and people   
    %img_name = '2007_009084'; % dogs, motorbike, chairs, people    
    %img_name = '2010_002868'; % buses   
    %img_name = '2010_003781'; % cat, bottle, potted plants
    img_name = 'Y0207_4';
    %img_name = 'Y0208_0';
    %img_name = 'Y0209_2';
    %img_name = 'Y0210_0';
    %img_name = 'Y0211_1';
    %img_name = 'Y0214_0';
    %img_name = 'Y0304_1';
    %img_name = 'Y0307_0';
    %img_name = 'Y0315_2';
    %img_name = 'Y0403_5';
    %img_name = 'Y0405_4';
    %img_name = 'Y0413_0';
    %img_name = 'Y0418_3';
    %img_name = 'Y0506_3';
    %img_name = 'Y0508_0';
        
   [masks, scores] = cpmc(exp_dir, img_name);
            
    I = imread([exp_dir '/JPEGImages/' img_name '.jpg']);

    % visualization and ground truth score for whole pool
    fprintf(['Best segments from initial pool of ' int2str(size(masks,3))]);
    Q = SvmSegm_segment_quality(img_name, exp_dir, masks, 'overlap');
    save('duh_32.mat', 'Q');
    avg_best_overlap = mean(max([Q.q]))
    SvmSegm_show_best_segments(I,Q,masks);
    
    % visualization and ground truth score for top 200 segments    
    top_masks = masks(:,:,1:200);
    figure;
    disp('Best 200 segments after filtering');
    Q = SvmSegm_segment_quality(img_name, exp_dir, top_masks, 'overlap');
    avg_best_overlap = mean(max([Q.q]))
    SvmSegm_show_best_segments(I,Q,top_masks);
    fprintf('Best among top 200 after filtering\n\n');    
end