import Foundation
import AlfredKatCore

if Workflow.next() == "do" {
    print(Workflow.notify(result: Workflow.do()))
} else {
    print(Workflow.menu())
}
