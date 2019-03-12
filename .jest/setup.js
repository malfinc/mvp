import * as emotion from "emotion"
import {createSerializer} from "jest-emotion"
import {configure} from "enzyme"
import Adapter from "enzyme-adapter-react-16"

configure({ adapter: new Adapter() })

expect.addSnapshotSerializer(createSerializer(emotion))
