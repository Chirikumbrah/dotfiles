import Cocoa

let args = CommandLine.arguments
let muted = args.count > 1 && args[1] == "off"
let percent = args.count > 2 ? args[2] : ""

let app = NSApplication.shared
app.setActivationPolicy(.accessory)

let size: CGFloat = 180

let mouseLocation = NSEvent.mouseLocation

guard let screen = NSScreen.screens.first(where: {
    $0.frame.contains(mouseLocation)
}) else {
    exit(1)
}

let panel = NSPanel(
    contentRect: NSRect(
        x: screen.frame.midX - size / 2,
        y: screen.frame.midY - size / 2,
        width: size,
        height: size
    ),
    styleMask: [.borderless, .nonactivatingPanel],
    backing: .buffered,
    defer: false
)

panel.level = .statusBar
panel.isOpaque = false
panel.backgroundColor = .clear
panel.hasShadow = true
panel.ignoresMouseEvents = true
panel.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]

let container = NSView(
    frame: NSRect(x: 0, y: 0, width: size, height: size)
)

container.wantsLayer = true
container.layer?.backgroundColor = NSColor.black.cgColor
container.layer?.cornerRadius = 28

let symbolName = muted ? "mic.slash.fill" : "mic.fill"
let tint: NSColor = muted ? .systemRed : .systemGreen

let iconSize: CGFloat = 72

let image = NSImage(
    systemSymbolName: symbolName,
    accessibilityDescription: nil
)!.withSymbolConfiguration(
    .init(pointSize: iconSize, weight: .medium)
)!

let imageView = NSImageView(
    frame: NSRect(
        x: (size - iconSize) / 2,
        y: 62,
        width: iconSize,
        height: iconSize
    )
)

imageView.image = image
imageView.contentTintColor = tint

let label = NSTextField(
    labelWithString: muted ? "Muted" : "\(percent)%"
)

label.frame = NSRect(
    x: 0,
    y: 25,
    width: size,
    height: 28
)

label.alignment = .center
label.font = .systemFont(ofSize: 20, weight: .semibold)
label.textColor = .white
label.isBezeled = false
label.isEditable = false
label.drawsBackground = false

container.addSubview(imageView)
container.addSubview(label)

panel.contentView = container

panel.orderFrontRegardless()

DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
    panel.orderOut(nil)
    app.terminate(nil)
}

app.run()
