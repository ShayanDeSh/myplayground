import asyncio

warr = []


async def handle_echo(reader, writer):
    writer.write("Enter your username: ".encode())
    await writer.drain()
    data = await reader.read(1024)
    name = data.decode()  # Return a string decoded from the given bytes.
    detail = {'name': name, 'writer': writer}
    warr.append(detail)
    while True:
        # Read up to n bytes. If n is not provided, or set to -1, read until EOF and return all read bytes.
        data = await reader.read(1024)
        # Return a string decoded from the given bytes.
        message = data.decode()
        # socket:
        # 'peername': the remote address to which the socket is connected,
        # result of socket.socket.getpeername() (None on error)
        tokken = message.split()
        if tokken[0] == "send":
            if tokken[1] == 'broadcast':
                for w in warr:
                    sendMsg = ' '.join(tokken[2:]) + '\n'
                    print(sendMsg)
                    w['writer'].write(sendMsg.encode())
                    await w['writer'].drain()
            else:
                for w in warr:
                    print(w.get('name'))
                    # add \r\n to match string we could parse it instead befroe saving
                    if w.get('name') == tokken[1] + '\r\n':
                        sendMsg = ' '.join(tokken[2:]) + '\n'
                        print(sendMsg)
                        w['writer'].write(sendMsg.encode())
                        await w['writer'].drain()
        elif tokken[0] == "exit":
            break
                # addr = writer.get_extra_info('peername')

                # {..!r} Calls repr() on the argument first
    writer.close()




async def main():
    server = await asyncio.start_server(
        handle_echo, '127.0.0.1', 8888)

    addr = server.sockets[0].getsockname()
    print(f'Serving on {addr}')

    async with server:
        await server.serve_forever()
    addr = server.sockets[0].getsockname()
    print(f'Serving on {addr}')

    async with server:
        await server.serve_forever()

if __name__ == '__main__':
    loop = asyncio.get_event_loop()
    try:
        loop.run_until_complete(main())
    except KeyboardInterrupt:
        print('Bye Bye')
        loop.close()
