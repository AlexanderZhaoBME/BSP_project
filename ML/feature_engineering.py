import os
import pandas as pd
from features.feature_extractor import Features
#%%
Fs = 300.0
waveform_path = 'E:\\学习资料\\大三上\\信号处理\\bsp_project\\ML\\data\\waveforms'
feature_path = 'E:\\学习资料\\大三上\\信号处理\\bsp_project\\ML\\data\\features'
#%%
filename_list = os.listdir(waveform_path)
dict_list = [{'filename': filename_list[i][2:8], 'label': filename_list[i][0]} for i in range(0, len(filename_list))]
labels = pd.DataFrame.from_dict(dict_list)
#%%
ecg_features = Features(file_path=waveform_path, fs=Fs, feature_groups=['full_waveform_features'], labels=labels)
ecg_features.extract_features(n_signals=None, show=True, normalize=True,
                              polarity_check=True, template_before=0.25, template_after=0.4)
#%%
features = pd.concat([labels, ecg_features.features], axis=1)
features.to_csv(os.path.join(feature_path, 'features.csv'), index=False)
