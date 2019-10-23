import React from "react";

import Label from "./Label";
import Input from "./Input";

const INPUT_SIZES = {
  large: "form-control-lg",
  small: "form-control-sm",
};
const specialClass = (type) => {
  switch (type) {
    case "checkbox":
    case "radio": {
      return "form-check";
    }
    case "file": {
      return "custom-file";
    }
    default: {
      return "";
    }
  }
};

export default function Field (properties) {
  const {scope, label, attribute, sizeClass, type, description, invalidFeedback, validFeedback, inputClassName, labelClassName, ...remainingProperties} = properties;
  const inputId = `${scope}-${attribute}`;
  const name = `${scope}[${attribute}]`;
  const labelId = `${inputId}-label`;
  const descriptionId = `${inputId}-description`;
  const inputSizeClassName = INPUT_SIZES[sizeClass] || "";
  const labelComponent = <Label id={labelId} type={type} labelClassName={labelClassName} {...remainingProperties}>{label}</Label>;
  const inputComponent = <Input id={inputId} type={type} name={name} labelId={labelId} descriptionId={descriptionId} inputClassName={inputClassName} inputSizeClassName={inputSizeClassName} {...remainingProperties} />;

  return <section className={`form-group ${specialClass(type)}`}>
    {specialClass(type) ? <>{inputComponent} {labelComponent}</> : <>{labelComponent} {inputComponent}</>}
    {description && <small id={descriptionId} className="form-text text-muted">{description}</small>}
    {invalidFeedback && <p className="invalid-feedback">
      {invalidFeedback}
    </p>}
    {validFeedback && <p className="valid-feedback">
      {validFeedback}
    </p>}
  </section>;
}
