# Tests for the presence of the expected workflow files

Feature: Workspace files

    As a researcher,
    I want to make sure that the workflow produces expected files in the workspace,
    So that I can be sure that the workflow outputs are correct.

    Scenario: The workspace contains the expected input files
        When the workflow execution completes
        Then the workspace should include "MLTrainDefinition.cfg"
        And the workspace should include "data.txt"
        And the workspace should include "env.sh"
        And the workspace should include "generate.C"
        And the workspace should include "generator_customization.C"
        And the workspace should include "globalvariables.C"
        And the workspace should include "handlers.C"
        And the workspace should include "plot.C"
        And the workspace should include "runTest.sh"
        And the workspace should include "fix-env.sh"

    Scenario: The AliESDs ROOT file is correctly fetched and present in the workspace
        When the workflow is finished
        Then the workspace should contain "__alice__data__2010__LHC10h_2__000139038/AliESDs.root"
        And the sha256 checksum of the file "__alice__data__2010__LHC10h_2__000139038/AliESDs.root" should be "dd11cbe9efa495c4495179126bda04c192580c111e9b744e3c8365e66fddd0d5"

    Scenario: The workflow generates the correct final plot
        When the workflow is finished
        Then the workspace should contain "plot.pdf"

    Scenario: The total workspace size remains within reasonable limits
        When the workflow is finished
        Then the workspace size should be more than 340MiB
        And the workspace size should be less than 380MiB
