import React from "react";
import {Route, Switch} from "react-router";

import ErrorBoundry from "./ErrorBoundry";
import {OurTechnology} from "@internal/pages";
import {PrivacyPolicy} from "@internal/pages";
import {TermsOfService} from "@internal/pages";
import {CodeOfConduct} from "@internal/pages";
import {TheCost} from "@internal/pages";
import {ThisIsUs} from "@internal/pages";
import {LandingPage} from "@internal/pages";
import {DataPolicy} from "@internal/pages";
import {SignUp} from "@internal/pages";
import {PageNotFound} from "@internal/pages";


export default function Application () {
  return <ErrorBoundry>
    <Switch>
      <Route path="/code-of-conduct" component={CodeOfConduct} />
      <Route path="/data-policy" component={DataPolicy} />
      <Route path="/our-technology" component={OurTechnology} />
      <Route path="/privacy-policy" component={PrivacyPolicy} />
      <Route path="/terms-of-service" component={TermsOfService} />
      <Route path="/the-cost" component={TheCost} />
      <Route path="/this-is-us" component={ThisIsUs} />
      <Route path="/sign-up" component={SignUp} />
      <Route exact path="/" component={LandingPage} />
      <Route component={PageNotFound} />
    </Switch>
  </ErrorBoundry>;
}
