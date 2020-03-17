from sklearn.metrics import roc_curve, auc
import numpy as np
import matplotlib.pylab as plt
import os

fig_route = 'C:\\Users\\hy\\Desktop\\bsp_project\\ML'

def evaluate_on_sample(pred, labels):
	TP = 0
	TN = 0
	FP = 0
	FN = 0
	for i, label in enumerate(labels):
		if int(label) == 1 and int(pred[i]) == 1:
			TP += 1
		if int(label) == 0 and int(pred[i]) == 0:
			TN += 1
		if int(label) == 1 and int(pred[i]) == 0:
			FN += 1
		if int(label) == 0 and int(pred[i]) == 1:
			FP += 1
	return TP, TN, FP, FN


def calculate_acc_spe_sen(TP, TN, FP, FN):
	ACC = (TP + TN) / (TP + TN + FP + FN)
	SPE = TN / (TN + FP)
	SEN = TP / (TP + FN)
	return ACC, SPE, SEN


def plot_roc_curve(y_true, scores):
	fpr, tpr, thresholds = roc_curve(y_true, scores)
	AUC = auc(fpr, tpr)
	plt.plot(fpr, tpr, 'b', linewidth=5)
	plt.plot(fpr, fpr, linestyle='--', color='k')
	plt.xlabel('False Positive Rate')
	plt.xticks(np.arange(0, 1.1, 0.1))
	plt.xlim(-0.002, 1)
	plt.ylabel('True Positive Rate')
	plt.yticks(np.arange(0, 1.1, 0.1))
	plt.ylim(0, 1.004)
	plt.title('ROC Curve')
	plt.grid()
	plt.text(600, 0.1, 'AUC = {:.3f}'.format(AUC))
	plt.savefig(os.path.join(fig_route, 'ROC_curve.png'))
	plt.show()
