import { createTRPCProxyClient, httpBatchLink } from "@trpc/client";
import type { AppRouter } from "../server";

const trpc = createTRPCProxyClient<AppRouter>({
  links: [
    httpBatchLink({
      url: "http://localhost:3000",
    }),
  ],
})

async function main() {
  const user = await trpc.userById.query("1");
  console.log("userById:\n", user);
  let users = await trpc.userAll.query();
  console.log("userAll:\n", users);
  console.log("Adding new user");
  await trpc.userCreate.mutate({ name: "测试用户"} );
  users = await trpc.userAll.query();
  console.log("添加用户之后:\n", users);
}

void main();
