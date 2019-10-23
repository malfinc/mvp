import React from "react";
import {get} from "@unction/complete";
import {mergeRight} from "@unction/complete";

const style = {
  display: "grid",
};

export default function Page (properties) {
  const {children} = properties;
  const {layoutStyle = {}} = properties;
  const dataComponent = get("data-component")(properties);

  return <main css={mergeRight(style)(layoutStyle)} data-component={dataComponent}>
    {children}
  </main>;
}
