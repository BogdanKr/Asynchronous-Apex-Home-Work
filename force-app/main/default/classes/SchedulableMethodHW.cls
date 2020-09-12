/**
 * Created by Bogdan on 12.09.2020.
 */

public with sharing class SchedulableMethodHW implements Schedulable{

    public static String CRON_EXP = '0 0 * * * ?';
    public static String CRON_EXP_2 = '0 30 * * * ?';

    public void execute(SchedulableContext param1) {
        BatchableMethodHW batchableMethodHW = new BatchableMethodHW();
        Database.executeBatch(batchableMethodHW);

        BatchIterableMethod batchIterableMethod = new BatchIterableMethod();
        Database.executeBatch(batchIterableMethod);
    }
}

//System.schedule('Job name', SchedulableMethodHW.CRON_EXP, new SchedulableMethodHW());

//SELECT Id, CronJobDetailId, TimesTriggered, CronJobDetail.Name, CronJobDetail.JobType, NextFireTime
//FROM CronTrigger

//System.abortJob('08e3V000004CYtKQAW');