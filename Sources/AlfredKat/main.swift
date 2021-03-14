import AlfredKatCore

print(
    Workflow.next() == "do"
        ? Workflow.notify(resultFrom: Workflow.do())
        : try Workflow.menu()
)
