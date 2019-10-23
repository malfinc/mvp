import React from "react";

export default function Label (properties) {
  const {id, inputId, label, labelClassName, type, children} = properties;
  if (type === "range") {
    return <label id={id} htmlFor={inputId}>{children}</label>;
  }

  if (type === "file") {
    return <label id={id} className="custom-file-label" htmlFor={inputId}>{children}</label>;
  }

  if (type === "textarea") {
    return <label id={id} htmlFor={inputId}>{children}</label>;
  }

  if (type === "select") {
    return <label id={id} htmlFor={inputId} className={labelClassName}>{children}</label>;
  }

  if (type === "radio" || type === "checkbox") {
    return <label id={id} className={`${labelClassName} form-check-label`} htmlFor={inputId}>{children}</label>;
  }

  return <label id={id} htmlFor={inputId}>{children}</label>;
}
