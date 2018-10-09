package example;

import func.nn.backprop.BackPropagationNetwork;
import func.nn.backprop.BackPropagationNetworkFactory;
import opt.OptimizationAlgorithm;
import opt.RandomizedHillClimbing;
import opt.SimulatedAnnealing;
import opt.example.NeuralNetworkOptimizationProblem;
import opt.ga.StandardGeneticAlgorithm;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import shared.DataSet;
import shared.ErrorMeasure;
import shared.Instance;
import shared.SumOfSquaresError;
import util.InstanceUtil;

import java.text.DecimalFormat;
import java.util.List;


public class EyeStateTest {
    private static final Logger LOGGER = LoggerFactory.getLogger(EyeStateTest.class);
    private static final String eyeFile = "C:\\Users\\AF55267\\Documents\\personal\\ML\\homework\\hw-2\\abagail2" +
            "\\data\\foo.csv";
    private static final int NUM_COLS = 15;
    private static final int LABEL_POS = 14;
    private static int inputLayer = 128, hiddenLayer = 64, outputLayer = 1, trainingIterations = 2000;
    private static DecimalFormat df = new DecimalFormat("0.000");
    private static String[] oaNames = {"RHC", "SA", "GA"};
    private static int[] optIterations = new int[]{1000, 2000, 50};

    private BackPropagationNetworkFactory factory = new BackPropagationNetworkFactory();

    private BackPropagationNetwork networks[] = new BackPropagationNetwork[3];
    private NeuralNetworkOptimizationProblem[] nnop = new NeuralNetworkOptimizationProblem[3];
    private OptimizationAlgorithm[] oa = new OptimizationAlgorithm[3];
//    private BackPropagationNetwork networks[] = new BackPropagationNetwork[1];
//    private NeuralNetworkOptimizationProblem[] nnop = new NeuralNetworkOptimizationProblem[1];
//    private OptimizationAlgorithm[] oa = new OptimizationAlgorithm[1];


    private DataSet set;
    private Instance[] trainSet;

    public EyeStateTest(String filename) {
        Instance[] allInstances = InstanceUtil.loadInstances(filename, NUM_COLS, true, LABEL_POS);
        List<Instance[]> testTrainList = InstanceUtil.testTrainSplit(allInstances, 5);
        trainSet = testTrainList.get(0);
        set = new DataSet(trainSet);
        // run setup
        setup();
        setupOptimizationAlgorithms();
        process();
    }

    public static void main(String[] args) {
        EyeStateTest eye = new EyeStateTest(eyeFile);
    }


    private void setup() {
        for (int i = 0; i < oa.length; i++) {
            networks[i] = factory.createClassificationNetwork(new int[]{inputLayer, hiddenLayer, outputLayer});
            nnop[i] = new NeuralNetworkOptimizationProblem(set, networks[i], new SumOfSquaresError());
        }
    }

    private void setupOptimizationAlgorithms() {
        oa[0] = new RandomizedHillClimbing(nnop[0]);
        oa[1] = new SimulatedAnnealing(1E11, .95, nnop[1]);
        oa[2] = new StandardGeneticAlgorithm(200, 100, 10, nnop[2]);
    }

    private void train(OptimizationAlgorithm oa, BackPropagationNetwork network, String oaName, Instance[] trainSet,
                       int myIterations) {
        int printThreshold = Math.round(myIterations / 10);
        ErrorMeasure measure = new SumOfSquaresError();
        LOGGER.info("\nError results for " + oaName + "\n---------------------------");
        for (int i = 0; i < myIterations; i++) {
            oa.train();
            double error = 0;
            for (int j = 0; j < trainSet.length; j++) {
                network.setInputValues(trainSet[j].getData());
                network.run();
                Instance output = trainSet[j].getLabel(), example = new Instance(network.getOutputValues());
                example.setLabel(new Instance(Double.parseDouble(network.getOutputValues().toString())));
                error += measure.value(output, example);
            }

            if (i % printThreshold == 0) {
                LOGGER.info("{}-> {}", i, df.format(error));
            }
        }
    }

    private void process() {
        for (int i = 0; i < oa.length; i++) {
            double start = System.nanoTime(), end, trainingTime, testingTime, correct = 0, incorrect = 0;
            train(oa[i], networks[i], oaNames[i], trainSet, optIterations[i]); //trainer.train();
            end = System.nanoTime();
            trainingTime = end - start;
            trainingTime /= Math.pow(10, 9);

            Instance optimalInstance = oa[i].getOptimal();
            networks[i].setWeights(optimalInstance.getData());

            double predicted, actual;
            start = System.nanoTime();
            int printThreshold = Math.round(trainSet.length / 10);

            for (int j = 0; j < trainSet.length; j++) {
                networks[i].setInputValues(trainSet[j].getData());
                networks[i].run();

                predicted = trainSet[j].getLabel().getContinuous();
                actual = networks[i].getOutputValues().get(0);
                if (Math.abs(predicted - actual) < 0.5) {
                    correct++;
                } else {
                    incorrect++;
                }
                end = System.nanoTime();
                testingTime = end - start;
                testingTime /= Math.pow(10, 9);

                if (j % printThreshold == 0) {
                    LOGGER.info("\n[{}]-> Results for " + oaNames[i] + ": \nCorrectly:" + correct +
                            " Incorrectly: " + incorrect + "  Percent correct: "
                            + df.format(correct / (correct + incorrect) * 100) + "% [Training time: " + df.format
                            (trainingTime) + " sec. Testing time: " + df.format(testingTime) + " sec.]\n");
                }
            }
            LOGGER.info("Final: %Correct={}");
        }
    }
}