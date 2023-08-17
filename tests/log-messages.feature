# Tests for the expected log messages

Feature: Log messages

    As a researcher,
    I want to make sure that my workflow execution correctly logged the messages,
    so that I can verify that the workflow ran correctly.

    Scenario: The data fetching steps have produced the expected messages
        When the workflow is finished
        Then the engine logs should contain "Publishing step:0, cmd: curl -fsOS --retry 9 http://opendata.cern.ch/record/1102/files/assets/alice/2010/LHC10h/000139038/ESD/0003/AliESDs.root"

    Scenario: The generation step has produced the expected messages
        When the workflow is finished
        Then the workspace should contain "generation.log"
        And the workspace should contain "generation.err"
        And the size of the file "generation.err" should be exactly 0
        And the file "generation.log" should contain
            """
            Processing generate.C...
            >>>>>>> Read train configuration
            Collection name='TObjArray', class='TObjArray', size=16
            """
        And the logs should contain
            """
            Processing generate.C...
            >>>>>>> Read train configuration
            Collection name='TObjArray', class='TObjArray', size=16
            """

    Scenario: The LEGO train step has produced the expected messages
        When the workflow is finished
        Then the logs should contain "#####   Analysis manager: train wrote to file <lego_train.root>"
        And the logs should contain "#####   Analysis macro to run on worker nodes <lego_train.C> written"
