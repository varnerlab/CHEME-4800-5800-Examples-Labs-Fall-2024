function loadparameters()
    return TOML.parsefile(joinpath(_PATH_TO_CONF, "Parameters.toml"));
end