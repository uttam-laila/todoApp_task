Feature: addNotes

    Test the add notes feature

    Scenario: Test the addNotes feature of the app
        Given I have "addNotes" button on homepage
        When I tap the "addNotes" button
        Then I should have "addNotesPage" on screen