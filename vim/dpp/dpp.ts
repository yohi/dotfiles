import {
  BaseConfig,
  ContextBuilder,
  Dpp,
  Plugin,
} from "https://deno.land/x/dpp_vim@v0.0.2/types.ts";
import { Denops, fn } from "https://deno.land/x/dpp_vim@v0.0.2/deps.ts";

type Toml = {
  hooks_file?: string;
  ftplugins?: Record<string, string>;
  plugins: Plugin[];
};

type LazyMakeStateResult = {
  plugins: Plugin[];
  stateLines: string[];
};

export class Config extends BaseConfig {
  override async config(args: {
    denops: Denops;
    contextBuilder: ContextBuilder;
    basePath: string;
    dpp: Dpp;
  }): Promise<{
    plugins: Plugin[];
    stateLines: string[];
  }> {
    args.contextBuilder.setGlobal({
      protocols: ["git"],
    });

    const [context, options] = await args.contextBuilder.get(args.denops);

    // Load toml plugins
    const tomls: Toml[] = [];
    const toml = await args.dpp.extAction(
      args.denops,
      context,
      options,
      "toml",
      "load",
      {
        path: "~/dotfiles/vim/dpp/toml/dein.toml",
        options: {
          lazy: false,
        },
      },
    ) as Toml | undefined;
    // console.log(toml);
    if (toml) {
      tomls.push(toml);
    }

    // console.log(tomls);

    // Merge toml results
    const recordPlugins: Record<string, Plugin> = {};
    const ftplugins: Record<string, string> = {};
    const hooksFiles: string[] = [];
    for (const toml of tomls) {
      for (const plugin of toml.plugins) {
        recordPlugins[plugin.name] = plugin;
      }

      if (toml.ftplugins) {
        for (const filetype of Object.keys(toml.ftplugins)) {
          if (ftplugins[filetype]) {
            ftplugins[filetype] += `\n${toml.ftplugins[filetype]}`;
          } else {
            ftplugins[filetype] = toml.ftplugins[filetype];
          }
        }
      }

      if (toml.hooks_file) {
        hooksFiles.push(toml.hooks_file);
      }
    }

    // const localPlugins = await args.dpp.extAction(
    //   args.denops,
    //   context,
    //   options,
    //   "local",
    //   "local",
    //   {
    //     directory: "~/work",
    //     options: {
    //       frozen: true,
    //       merged: false,
    //     },
    //   },
    // ) as Plugin[] | undefined;

    // if (localPlugins) {
    //   // Merge localPlugins
    //   for (const plugin of localPlugins) {
    //     if (plugin.name in recordPlugins) {
    //       recordPlugins[plugin.name] = Object.assign(
    //         recordPlugins[plugin.name],
    //         plugin,
    //       );
    //     } else {
    //       recordPlugins[plugin.name] = plugin;
    //     }
    //   }
    // }

    // console.log(recordPlugins);

    const lazyResult = await args.dpp.extAction(
      args.denops,
      context,
      options,
      "lazy",
      "makeState",
      {
        plugins: Object.values(recordPlugins),
      },
    ) as LazyMakeStateResult | undefined;

    return {
      ftplugins,
      hooksFiles,
      plugins: lazyResult?.plugins ?? [],
      stateLines: lazyResult?.stateLines ?? [],
    };
  }
}
