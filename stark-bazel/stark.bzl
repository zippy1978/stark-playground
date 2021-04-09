StarkModuleInfo = provider(
    doc = "Stark module provider",
    fields = {
        "test": "test",
        "dir": "Module directory",
        "deps": "A depset of info structs for this module's dependencies",
    },
)

def starkc(ctx, srcs, out, deps = []):
    """starkc compilation from sources.

    Args:
        ctx: analysis context.
        srcs: list of source Files to be compiled.
        out: output file (for main module) or directory (if module),
        deps: list of StarkModuleInfo objects for direct dependencies.
    """

    modules = []
    module_dirs = []
    for dep in deps:
        modules.append(dep.dir.path)
        module_dirs.append(dep.dir)

    cmd = "starkc {modules} -o {out} -- {srcs}".format(
        modules =  "-m " + ":".join(modules) if len(deps) > 0 else "",
        out = out.path,
        srcs = " ".join([src.path for src in srcs]),
    )
    ctx.actions.run_shell(
        outputs = [out],
        inputs = srcs + module_dirs,
        command = cmd,
        mnemonic = "StarkC",
        use_default_shell_env = True,
    )

# stark_module

def _stark_module_impl(ctx):
    dir = ctx.actions.declare_directory(ctx.label.name)
    deps = ctx.attr.deps

    starkc(
        ctx,
        srcs = ctx.files.srcs,
        out = dir,
        deps = [dep[StarkModuleInfo] for dep in deps],
    )

    return [
        DefaultInfo(files = depset([dir])),
        StarkModuleInfo(
            dir = dir,
            deps = depset(
                direct = [dep[StarkModuleInfo].dir for dep in deps],
                transitive = [dep[StarkModuleInfo].deps for dep in deps],
            ),
        ),
    ]

stark_module = rule(
    attrs = {
        "srcs": attr.label_list(
            allow_files = [".st"],
            doc = "Source files to compile",
        ),
        "deps": attr.label_list(
            providers = [StarkModuleInfo],
            doc = "Direct dependencies of the module",
        ),
    },
    implementation = _stark_module_impl,
)

# stark_binary
# TODO add more attributs for option support !

def _stark_binary_impl(ctx):
    deps = ctx.attr.deps

    executable_path = "{name}%/{name}".format(name = ctx.label.name)
    executable = ctx.actions.declare_file(executable_path)

    starkc(
        ctx,
        srcs = ctx.files.srcs,
        out = executable,
        deps = [dep[StarkModuleInfo] for dep in deps],
    )

    return [DefaultInfo(files = depset([executable]), executable = executable)]

stark_binary = rule(
    doc = "Builds an executable program from Stark source code",
    executable = True,
    attrs = {
        "srcs": attr.label_list(
            allow_files = [".st"],
            doc = "Source files to compile",
        ),
        "deps": attr.label_list(
            providers = [StarkModuleInfo],
            doc = "Direct dependencies of the binary",
        ),
    },
    implementation = _stark_binary_impl,
)
